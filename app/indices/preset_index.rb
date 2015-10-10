ThinkingSphinx::Index.define :preset, :with => :active_record do
    # fields
    indexes name
    indexes desc

    # attributes
    has user_id, created_at, updated_at
end