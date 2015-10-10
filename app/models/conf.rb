class Conf < ActiveRecord::Base
    validates :name, presence: true
    validates :desc, presence: true
end
