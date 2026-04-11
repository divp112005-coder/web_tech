var app = angular.module('foodOrderApp', ['ngRoute']);

app.config(function($routeProvider) {
    $routeProvider
    .when("/", {
        templateUrl : "views/menu.html",
        controller : "MenuController"
    })
    .when("/menu", {
        templateUrl : "views/menu.html",
        controller : "MenuController"
    })
    .when("/login", {
        templateUrl : "views/login.html",
        controller : "AuthController"
    })
    .when("/register", {
        templateUrl : "views/register.html",
        controller : "AuthController"
    })
    .when("/cart", {
        templateUrl : "views/cart.html",
        controller : "CartController"
    })
    .when("/profile", {
        templateUrl : "views/profile.html",
        controller : "ProfileController"
    })
    .otherwise({
        redirectTo: "/"
    });
});

// Service to manage User Authentication state
app.factory('AuthService', function($window) {
    return {
        setUser: function(user) {
            $window.localStorage.setItem('user', JSON.stringify(user));
        },
        getUser: function() {
            var user = $window.localStorage.getItem('user');
            return user ? JSON.parse(user) : null;
        },
        logout: function() {
            $window.localStorage.removeItem('user');
        },
        isLoggedIn: function() {
            return $window.localStorage.getItem('user') !== null;
        }
    };
});

// Service to manage Cart state
app.factory('CartService', function($window) {
    var cart = [];
    
    // Load from local storage if exists
    var savedCart = $window.localStorage.getItem('cart');
    if (savedCart) {
        cart = JSON.parse(savedCart);
    }

    function saveCart() {
        $window.localStorage.setItem('cart', JSON.stringify(cart));
    }

    return {
        getCart: function() {
            return cart;
        },
        addItem: function(item) {
            var existing = cart.find(i => i.id === item.id);
            if (existing) {
                existing.quantity += 1;
            } else {
                item.quantity = 1;
                cart.push(item);
            }
            saveCart();
        },
        removeItem: function(itemId) {
            cart = cart.filter(i => i.id !== itemId);
            saveCart();
            return cart;
        },
        updateQuantity: function(itemId, change) {
            var item = cart.find(i => i.id === itemId);
            if (item) {
                item.quantity += change;
                if (item.quantity <= 0) {
                    this.removeItem(itemId);
                } else {
                    saveCart();
                }
            }
            return cart;
        },
        clearCart: function() {
            cart = [];
            saveCart();
        },
        getTotal: function() {
            return cart.reduce((total, item) => total + (item.price * item.quantity), 0);
        },
        getCount: function() {
            return cart.reduce((count, item) => count + item.quantity, 0);
        }
    };
});

// Controller for Navigation
app.controller('NavController', function($scope, $location, AuthService, CartService) {
    $scope.isLoggedIn = AuthService.isLoggedIn;
    
    $scope.$watch(function() { return AuthService.getUser(); }, function(newVal) {
        $scope.currentUser = newVal;
    });

    $scope.$watch(function() { return CartService.getCount(); }, function(newVal) {
        $scope.cartCount = function() { return newVal; };
    });

    $scope.logout = function() {
        AuthService.logout();
        CartService.clearCart(); 
        $location.path('/login');
    };
});

// Controller for Auth (Login & Register)
app.controller('AuthController', function($scope, $http, $location, AuthService) {
    $scope.loginData = {};
    $scope.regData = {};
    $scope.errorMessage = '';

    $scope.login = function() {
        // Vanilla JS Validation
        if (!$scope.loginData.username || !$scope.loginData.password) {
            alert("Please enter both username and password.");
            return;
        }

        $http.post('api/login.php', $scope.loginData)
        .then(function(response) {
            AuthService.setUser(response.data.user);
            $location.path('/menu');
        }, function(error) {
            $scope.errorMessage = error.data.message || "Login failed.";
            alert($scope.errorMessage); 
        });
    };

    $scope.register = function() {
        // Vanilla JS Valdiation
        if (!$scope.regData.first_name || !$scope.regData.last_name || !$scope.regData.username || !$scope.regData.email || !$scope.regData.password) {
            alert("All fields are required. Please fill out the registration form completely.");
            return;
        }

        if ($scope.regData.password.length < 6) {
            alert("Password must be at least 6 characters long.");
            return;
        }

        $http.post('api/register.php', $scope.regData)
        .then(function(response) {
            alert("Registration successful! Please login.");
            $location.path('/login');
        }, function(error) {
            $scope.errorMessage = error.data.message || "Registration failed.";
            alert($scope.errorMessage);
        });
    };
});

// Controller for Menu
app.controller('MenuController', function($scope, $http, CartService, AuthService, $location) {
    $scope.groupedMenu = {};
    
    $http.get('api/menu.php')
    .then(function(response) {
        if(response.data.records) {
            // Group items by category
            var items = response.data.records;
            items.forEach(function(item) {
                if (!$scope.groupedMenu[item.category]) {
                    $scope.groupedMenu[item.category] = [];
                }
                $scope.groupedMenu[item.category].push(item);
            });
        }
    }, function(error) {
        console.error("Error fetching menu:", error);
    });

    $scope.addToCart = function(item) {
        if (!AuthService.isLoggedIn()) {
            alert("Please login to add items to your cart.");
            $location.path('/login');
            return;
        }
        CartService.addItem(angular.copy(item));
        alert(item.name + " added to cart!");
    };
});

// Controller for Cart & Checkout
app.controller('CartController', function($scope, $http, $location, CartService, AuthService) {
    if (!AuthService.isLoggedIn()) {
        $location.path('/login');
        return;
    }

    $scope.cart = CartService.getCart();
    $scope.total = CartService.getTotal();

    $scope.updateQuantity = function(itemId, change) {
        $scope.cart = CartService.updateQuantity(itemId, change);
        $scope.total = CartService.getTotal();
    };

    $scope.removeItem = function(itemId) {
        if(confirm("Are you sure you want to remove this item?")) {
            $scope.cart = CartService.removeItem(itemId);
            $scope.total = CartService.getTotal();
        }
    };

    $scope.checkout = function() {
        if ($scope.cart.length === 0) {
            alert("Your cart is empty.");
            return;
        }

        // Vanilla JS prompt for confirmation
        var confirmText = prompt("Type 'CONFIRM' to place your order of ₹" + $scope.total.toFixed(2));
        
        if (confirmText === 'CONFIRM') {
            var user = AuthService.getUser();
            var orderData = {
                user_id: user.id,
                total_price: $scope.total,
                cart_items: $scope.cart
            };

            $http.post('api/place_order.php', orderData)
            .then(function(response) {
                alert("Order placed successfully! Order ID: " + response.data.order_id);
                CartService.clearCart();
                $location.path('/menu');
            }, function(error) {
                alert("Failed to place order: " + (error.data.message || "Unknown error"));
            });
        } else if (confirmText !== null) {
            alert("Checkout cancelled: You did not type 'CONFIRM'.");
        }
    };
});

// Controller for Profile
app.controller('ProfileController', function($scope, $http, $location, AuthService) {
    if (!AuthService.isLoggedIn()) {
        $location.path('/login');
        return;
    }

    $scope.profileData = {};
    var currentUser = AuthService.getUser();

    $http.post('api/profile.php', { user_id: currentUser.id })
    .then(function(response) {
        $scope.profileData = response.data;
    }, function(error) {
        alert("Failed to load profile data: " + (error.data.message || "Unknown error"));
    });
});
