ThinkingSphinx::Index.define :product, :with => :active_record do
  indexes title, :sortable => true
  indexes description
  has user_id, created_at, updated_at
end
