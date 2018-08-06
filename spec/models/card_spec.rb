# spec/models/card_spec.rb
require 'rails_helper'

# Test suite for the Card model
RSpec.describe Card, type: :model do
  # Association test
  # ensure a card record belongs to a single list record
  it { should belong_to(:list) }
  # Validation test
  # ensure column title is present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
end
