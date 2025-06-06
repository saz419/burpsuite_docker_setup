from burp import IBurpExtender

class BurpExtender(IBurpExtender):
    def registerExtenderCallbacks(self, callbacks):
        self._callbacks = callbacks
        self._helpers = callbacks.getHelpers()
        callbacks.setExtensionName("My Python Extension")
        
        # Example: print to Burp's output tab
        callbacks.printOutput("Hello from My Python Extension!")
