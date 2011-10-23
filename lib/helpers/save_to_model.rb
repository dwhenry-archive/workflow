module SaveToModel
  def save_to_model(klass, fields)
    model = (@id ? klass.find({:id => @id}) : klass.new)
    fields.each { |field| model.send("#{field}=", self.send(field)) }

    result = model.save
    @id, @errors = model.id, model.errors
    return result
  end
end