module Emcee
  class BaseError < StandardError;end

  class RouteError < BaseError;end
  class DuplicateTitleError < RouteError;end
end
