# Mass Transit

## Notes

### Database Indeces
```
routes      : CREATE INDEX routes_route_id_index ON routes(route_id)
stop_times  : CREATE INDEX stop_id_index ON stop_times(stop_id)
            : CREATE INDEX trip_id_index ON stop_times(trip_id)
            : CREATE INDEX stop_sequence_index ON stop_times(stop_sequence)
stops       : CREATE INDEX stops_stop_id_index ON stops(stop_id)
trips       : CREATE INDEX route_id_index ON trips(route_id)
```

## Bugs
1. Zooming in on the map pdf multiple times currently causes the map to disappear

## Dependencies

Icons provided by Icons8 (http://icons8.com/)
PDFScrollView + TiledPDFView - Michael Shafae 10/22/12
Google Transit Feed Service (MTA.sl3, OCTA.sl3)

### CocoaPods
FMDB (via Cocoa Pods) From: https://github.com/ccgus/fmdb