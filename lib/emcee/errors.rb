module Emcee
  class BaseError   < StandardError;end
  class RouteError  < BaseError;end

  class UnknownCommandError < RouteError
    def initialize(cmd)
      msg = "Command '#{cmd}' is now recognized"
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
