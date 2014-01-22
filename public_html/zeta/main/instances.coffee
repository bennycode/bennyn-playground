# Init view models
window.Zeta.Instances = 
  MainViewModel: new Zeta.ViewModel.MainViewModel()

# Create view bindings
$(document).ready ->
  ko.applyBindings Zeta.Instances.MainViewModel, document.getElementById "conversation-list-grid"