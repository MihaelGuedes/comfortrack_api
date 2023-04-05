class EnableExtensions < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    enable_extension 'plpgsql' unless extension_enabled?('plpgsql')
  end
end
