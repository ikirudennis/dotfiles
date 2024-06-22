Common Role
===========

This role mostly exists to run other dependent roles.

Dependencies
------------

Reminder: dependencies run _before_ the role to which they are defined in.
I ran into this as an issue when I was creating the `graphical` role. I wanted
to run the check for a graphical environment as a task here in the common role,
but including `graphical` as a dependent role meant that the check would happen
_after_ the graphical role ran. So the check is in the graphical role and thus
the graphical role will probably always have to come first because of that.

- graphical
- fedora (will only run if we're running in a fedora system)
- pip
