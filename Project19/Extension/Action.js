
var Action = function () {}

Action.prototype = {
run: function(parameters) {
    parameters.completionFunction({"URL": document.URL, "title": document.title});
},
finalize: function(parameters) {
    var customJavascript = parameters["customJavaScript"];
    eval(customJavascript);
}
};


var ExtensionPreprocessingJS = new Action
