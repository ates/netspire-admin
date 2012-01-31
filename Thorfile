require File.expand_path('../config/environment', __FILE__)

class App < Thor
  class Db < Thor
    desc "recreate", "Recreate databases"
    method_option :names, default: [:default, :template], type: :array, aliases: "-D"
    def recreate
      options[:names].each do |name|
        db = COUCHDB_SERVER.available_databases[name.to_sym]
        db.recreate! if db
      end
    end

    desc "push_ddocs", "Push design docs"
    method_option :recreate, default: false, type: :boolean, aliases: "-F"
    def push_ddocs
      COUCHDB_SERVER.available_databases.each do |name, db|
        db.recreate! if options[:recreate]

        Dir[File.expand_path("../db/ddocs/#{name}/*", __FILE__)].each do |path|
          ddoc = CouchRest::Design.build(path)
          ddoc.database = db

          begin
            ddoc.save
          rescue RestClient::Conflict
            prev = db.get(ddoc.id)
            ddoc["_rev"] = prev.rev
            ddoc.save
          end
        end
      end
    end

    desc "seed", "Seed database with example data"
    def seed
      Rails.application.load_seed
    end

    desc "setup", "Create the database, load the schema, and initialize with the seed data"
    def setup
      invoke :push_ddocs, [], recreate: true
      invoke :seed
    end
  end
end
