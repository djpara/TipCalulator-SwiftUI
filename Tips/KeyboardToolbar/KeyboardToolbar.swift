#if canImport(UIKit)
import SwiftUI

internal struct KeyboardToolbar: View {
    var items: [KeyboardToolbarItem]
    var style: KeyboardToolbarStyle
    var leadingItems: [KeyboardToolbarItem] {
        items.filter { $0.isFixed == .leading }
    }
    var trailingItems: [KeyboardToolbarItem] {
        items.filter { $0.isFixed == .trailing }
    }
    var scrollingItems: [KeyboardToolbarItem] {
        items.filter { $0.isFixed == nil }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            leadingItemsView
            if !leadingItems.isEmpty {
                divider
            }
            scrollingItemsView
            if !trailingItems.isEmpty {
                divider
            }
            trailingItemsView
        }
        .frame(height: style.height)
        .padding(.horizontal, style.itemSpacing)
        .background(style.backgroundColor)
    }
    
    func itemGroup(_ items: [KeyboardToolbarItem]) -> some View {
        ForEach(items) { item in
            Button(action: item.callback, label: {
                viewForToolbarItem(item)
            })
            .contentShape(Rectangle())
        }
    }
    
    private func viewForToolbarItem(_ item: KeyboardToolbarItem) -> AnyView {
        if (item.image != nil || item.text == nil) {
            return AnyView(item.image!)
        } else {
            return AnyView(Text(item.text ?? "")
                .font(.system(size: style.itemSize))
                .foregroundColor(item.color)
                .frame(height: style.itemSize)
                .frame(minWidth: max(style.itemSize, style.height))
                .frame(height: style.height))
        }
    }
    
    var leadingItemsView: some View {
        HStack(spacing: style.itemSpacing) {
            itemGroup(leadingItems)
        }
    }
    
    var scrollingItemsView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: style.itemSpacing) {
                itemGroup(scrollingItems)
            }
        }
    }
    
    var trailingItemsView: some View {
        HStack(spacing: style.itemSpacing) {
            itemGroup(trailingItems)
        }
    }
    
    var divider: some View {
        Rectangle()
            .frame(width: style.dividerWidth)
            .foregroundColor(style.dividerColor)
            .padding(.vertical, 5)
            .padding(.horizontal, style.itemSpacing)
    }
}

struct KeyboardToolbar_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardToolbar(items: [
            KeyboardToolbarItem(systemName: "xmark.circle", callback: {}),
            KeyboardToolbarItem(systemName: "checkmark.circle", callback: {}),
            KeyboardToolbarItem(text: #"\"#, color: .red, callback: {}),
            KeyboardToolbarItem(text: "apple", color: .red, callback: {}),
        ], style: .standard)
    }
}
#endif
