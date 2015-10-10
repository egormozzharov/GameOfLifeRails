ThinkingSphinx::Index.define :conf, :with => :active_record do
    # fields
    indexes name
    indexes desc

    # attributes
    has user_id, created_at, updated_at, alive, die
end
