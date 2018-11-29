module MindPlant
  class FileInput
    def self.run(filename)
      app = Application.new

      File.read(filename).split("\n").each do |command|
        app.run_command(command)
      end

      app.print_report

      exit
    end
  end
end