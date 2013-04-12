// Call this function to start Postcard on the Run. Need to pass in the API key for the property.
// launchPostcard(apiKey);
// Add to Cordova.plist. key: Postcard value: CDVPostcard

function launchPostcard (apiKey) {
    if (typeof apiKey ==="undefined"){apiKey= '';}
    cordova.exec(function(){},function(err){console.log(err);alert(err);},"Postcard","startPostcardWithAPIkey",[apiKey]);
}
