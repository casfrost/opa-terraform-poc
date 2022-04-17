package tfplan

locationRule[msg] {
        changeset := input.resource_changes[_]

        is_create_or_update(changeset.change.actions)

        changeset.type = "azurerm_linux_web_app"
        changeset.change.after.location != "westeurope"

        msg := sprintf("Azure Linux App Service %v has to be located in West Europe.", [changeset.name])
}

skuRule[msg] {
    changeset := input.resource_changes[_]

    is_create_or_update(changeset.change.actions)

    changeset.type = "azurerm_service_plan"
    changeset.change.after.sku_name != "P1v2"

    msg := sprintf("Azure Linux App Service %v has to be of type P1v2", [changeset.name])
}
# Methods to check whether if the resource are being created or updated
is_create_or_update(actions) {
        actions[_] == "create"
}

is_create_or_update(actions) {
        actions[_] == "update"
}