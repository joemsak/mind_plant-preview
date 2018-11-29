module MindPlant
  class FileInput
    def self.run(filename)
      app = Application.new

      File.open(filename) do |file|
        file.lazy.each_slice(1_000) do |lines|
          lines.each do |line|
            app.run_command(line) rescue next
          end
        end
      end

      app.print_report

      exit
    end
  end
end