# spec/models/list_spec.rb
require 'rails_helper'

# Test suite for the List model
RSpec.describe List, type: :model do
  # Association test
  # ensure List model has a 1:m relationship with the Card model
  it { should have_many(:cards).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
