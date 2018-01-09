class ContextBase
  include DCI::Context

  def self.perform(*args)
    ctx = new(*args)
    ctx.perform
  end
end
