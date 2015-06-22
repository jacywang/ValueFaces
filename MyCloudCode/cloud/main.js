
// Use Parse.Cloud.define to define as many cloud functions as you want.

var fs = require('fs');
var layer = require('cloud/layer-parse-module/layer-module.js');

var layerProviderID = '371fe712-1900-11e5-8d1d-27936d001b74';
var layerKeyID = '21ec1ce8-190b-11e5-9121-27936d000e70';
var privateKey = fs.readFileSync('cloud/layer-parse-module/keys/layer-key.js');
layer.initialize(layerProviderID, layerKeyID, privateKey);

Parse.Cloud.define("generateToken", function(request, response) {
    var userID = request.params.userID;
    var nonce = request.params.nonce;
    if (!userID) throw new Error('Missing userID parameter');
    if (!nonce) throw new Error('Missing nonce parameter');
        response.success(layer.layerIdentityToken(userID, nonce));
});