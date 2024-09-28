# frozen_string_literal: true

# ApplicationRecordは、アプリケーション内のすべてのモデルの基底クラスです。
# このクラスを継承することで、ActiveRecordの機能を利用できます。
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
