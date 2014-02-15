'use strict'

describe 'spike', () ->
  $httpBackend = null
  scope = null

  dummy = {
    name: "hoge"
    version: "fuga"
  }

  beforeEach ->
    module 'spike'

    inject ($injector, $rootScope, $controller) ->
      $httpBackend = $injector.get('$httpBackend')
      $httpBackend.whenGET('module/resource/version.json').respond(dummy)
      scope = $rootScope.$new()
      ctrl = $controller 'versionController', {$scope: scope}

  it 'version情報を取得する', () ->
    $httpBackend.flush()
    expect(scope.version).toEqual dummy
