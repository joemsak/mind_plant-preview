module MindPlant
  class FileInput
    def self.run(filename)
      app = Application.new

      IO.foreach(filename).lazy.each do |line|
        app.run_command(line) rescue next
      end

      app.print_report

      exit
    end
  end
end