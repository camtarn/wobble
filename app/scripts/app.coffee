angular
  .module('wobbleApp', [
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when('/', {
        templateUrl: 'views/loading.html',
        controller: 'LoadingCtrl',
        controllerAs: 'loading'
      })
      .when('/main', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
        controllerAs: 'main'
      })
      .when('/about', {
        templateUrl: 'views/about.html',
        controller: 'AboutCtrl',
        controllerAs: 'about'
      })
      .otherwise({
        redirectTo: '/'
      })

