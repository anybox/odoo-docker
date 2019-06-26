#!/bin/bash
createuser -U postgres -d odoo
createdb -U postgres -O odoo odoo
