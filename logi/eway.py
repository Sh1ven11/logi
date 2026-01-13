import frappe
from frappe.utils import add_days, nowdate

def send_eway_expiry_reminders():
    tomorrow = add_days(nowdate(), 1)

    consignments = frappe.get_all(
        "Consignment Note",
        filters={
            "eway_bill_expiry_date": tomorrow,
            "eway_bill_no": ["!=", ""],
            "docstatus": ["<", 2],
            "eway_reminder_sent": 0   # important safeguard
        },
        fields=["name"]
    )

    for c in consignments:
        doc = frappe.get_doc("Consignment Note", c.name)

        frappe.sendmail(
            recipients=["shivengupta11@gmail.com"],  # move to settings later
            template="E-Way Bill Expiry Reminder",
            args={"doc": doc},
            reference_doctype="Consignment Note",
            reference_name=doc.name
        )

        doc.eway_reminder_sent = 1
        doc.save(ignore_permissions=True)

