module MindPlant
  class ConsoleInput
    def self.run
      commands = []

      at_exit do
        app = Application.new

        commands.each do |command|
          app.run_command(command) rescue next
        end

        $stdout.puts("")
        $stdout.puts("")

        app.print_report

        $stdout.puts("")
      end

      loop do
        command = $stdin.gets.chomp

        if command == 'q'
          exit
        else
          commands.push(command)
        end
      end
    end
  end
end