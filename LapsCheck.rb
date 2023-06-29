require 'win32/registry'
 def check_laps_installed
  key_path = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
  laps_display_name = 'Local Administrator Password Solution'
   begin
    Win32::Registry::HKEY_LOCAL_MACHINE.open(key_path) do |reg|
      reg.each_key do |key, _|
        Win32::Registry::HKEY_LOCAL_MACHINE.open("#{key_path}\\#{key}") do |subkey|
          display_name = subkey['DisplayName']
          return true if display_name && display_name.include?(laps_display_name)
        end
      end
    end
  rescue
    return false
  end
   false
end
 if check_laps_installed
  puts '[+] LAPS installed'
else
  puts '[-] LAPS not installed'
end
