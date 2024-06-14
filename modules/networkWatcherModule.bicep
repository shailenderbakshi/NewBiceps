param location string
param networkWatcherName string = 'NetworkWatcher_${location}'

resource networkWatcher 'Microsoft.Network/networkWatchers@2021-02-01' = {
  name: networkWatcherName
  location: location
}

output networkWatcherId string = networkWatcher.id
