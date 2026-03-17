//
//  MainContentCoordinator+SchemaMetadata.swift
//  TablePro
//
//  Extracted schema metadata helpers from MainContentCoordinator.swift to reduce file length.
//

import Foundation
import TableProPluginKit

extension MainContentCoordinator {
    /// Parsed schema metadata ready to apply to a tab
    struct ParsedSchemaMetadata {
        let columnDefaults: [String: String?]
        let columnForeignKeys: [String: ForeignKeyInfo]
        let columnNullable: [String: Bool]
        let primaryKeyColumn: String?
        let approximateRowCount: Int?
    }

    /// Schema result from parallel or sequential metadata fetch
    typealias SchemaResult = (columnInfo: [ColumnInfo], fkInfo: [ForeignKeyInfo], approximateRowCount: Int?)

    /// Parse a SchemaResult into dictionaries ready for tab assignment
    func parseSchemaMetadata(_ schema: SchemaResult) -> ParsedSchemaMetadata {
        var defaults: [String: String?] = [:]
        var fks: [String: ForeignKeyInfo] = [:]
        var nullable: [String: Bool] = [:]
        for col in schema.columnInfo {
            defaults[col.name] = col.defaultValue
            nullable[col.name] = col.isNullable
        }
        for fk in schema.fkInfo {
            fks[fk.column] = fk
        }
        return ParsedSchemaMetadata(
            columnDefaults: defaults,
            columnForeignKeys: fks,
            columnNullable: nullable,
            primaryKeyColumn: schema.columnInfo.first(where: { $0.isPrimaryKey })?.name,
            approximateRowCount: schema.approximateRowCount
        )
    }
}
