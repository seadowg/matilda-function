class Proc
  def self.recursive(&block)
    Proc.new do |args|
      step = RecursiveStep.new
      returned = block.call(step, *args)

      while returned.kind_of?(RecursiveStep)
        returned = block.call(step, *returned.args)
      end

      returned
    end
  end

  def <<(func)
    Proc.new do |*args|
      func.call(self.call(*args))
    end
  end

  private

  class RecursiveStep
    attr_reader :args

    def call(*args)
      @args = args
      self
    end
  end
end

module RecursiveExtension
  def self.extended(mod)
    mod.module_eval do
      def recursive(&block)
        Proc.recursive(&block)
      end
    end
  end
end

module Kernel
  extend RecursiveExtension
end
