// SettingHeader.swift
// Copyright (C) 2020 Presidenza del Consiglio dei Ministri.
// Please refer to the AUTHORS file for more information.
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Affero General Public License for more details.
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.

import Extensions
import Foundation
import Tempura

struct SettingHeaderVM: ViewModel {
  let header: SettingsVM.Header

  var title: String {
    switch self.header {
    case .data:
      return L10n.Settings.Setting.Section.data
    case .info:
      return L10n.Settings.Setting.Section.info
    case .general:
      return L10n.Settings.Setting.Section.general
    }
  }
}

class SettingHeader: UICollectionReusableView, ModellableView, ReusableView {
  typealias VM = SettingHeaderVM

  let title = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.style()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
    self.style()
  }

  func setup() {
    self.addSubview(self.title)
  }

  func style() {
    Self.Style.container(self)
  }

  func update(oldModel: VM?) {
    guard let model = self.model else {
      return
    }

    Self.Style.title(self.title, content: model.title)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    self.title.pin
      .horizontally(SettingsView.collectionInset)
      .sizeToFit(.width)
      .bottom(13 + SettingsView.shadowVerticalInset)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let labelWidth = size.width - 2 * SettingsView.collectionInset
    let titleSize = self.title.sizeThatFits(CGSize(width: labelWidth, height: CGFloat.infinity))
    return CGSize(width: size.width, height: titleSize.height + 45 + 2 * SettingsView.shadowVerticalInset)
  }
}

private extension SettingHeader {
  enum Style {
    static func container(_ view: UIView) {
      view.backgroundColor = .clear
    }

    static func title(_ label: UILabel, content: String) {
      let textStyle = TextStyles.pSemibold.byAdding(
        .color(Palette.grayNormal),
        .alignment(.left)
      )

      TempuraStyles.styleShrinkableLabel(
        label,
        content: content,
        style: textStyle
      )
    }
  }
}
