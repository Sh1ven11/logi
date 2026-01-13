import frappe

def update_consignments(doc, method):
    if not doc.get("custom_list_of_consignments"):
        return

    for row in doc.get("custom_list_of_consignments"):
        if not row.consignment_note:
            continue

        frappe.db.set_value(
            "Consignment Note",
            row.consignment_note,
            {
                "invoiced": 1,
                "sales_invoice": doc.name
            },
            update_modified=False
        )

