module Emcee
  class BaseError   < StandardError;end
  class RouteError  < BaseError;end

  class NoSuchCommandError < RouteError
    def initialize(cmd)
      msg = "No such command '#{cmd}'"
      super(msg)
    end
  end

  class DuplicateTitleError < RouteError
    def initialize(title)
      msg = "You cannot create another album with the title '#{title}'"
      super(msg)
    end
  end

  class TitleNotFoundError < RouteError
    def initialize(title)
      msg = "Title '#{title}' not found"
      super(msg)
    end
  end
end
