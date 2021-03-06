require "sequel"

require "ranked/log"
require "ranked/conf"
require "ranked/autoload"

module Task
  include Ranked

  def db
    @db ||= Sequel.connect(Conf.database_url)
  end

  def run
    Log.notice event: "run"
    ok = db.test_connection
    Log.notice ok: ok
    if ok
      db.tables.each { |model| Sequel::Model(model) }
      main
    end
  end
end
