# frozen_string_literal: true

# Top level ORM
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
