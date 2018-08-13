desc 'Counter cache for Card has many comments'

task comment_counter: :environment do
  Card.reset_column_information
  Card.pluck(:id).each do |p|
    Card.reset_counters p.id, :comments
  end
end
