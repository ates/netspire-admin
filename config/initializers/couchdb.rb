COUCHDB_SERVER = CouchRest.new
COUCHDB_SERVER.default_database = 'test'
CouchRest.use_database(COUCHDB_SERVER.default_database)
