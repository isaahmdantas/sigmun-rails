class HabilitarUuid < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pgcrypto'
    enable_extension 'unaccent'
  end
end
