fluid-obj-c
===========

Shiny new objective-c client lib for Fluidinfo

Provides an OO Obj-c interface for working with Fluidinfo's objects, tags, values, namespaces, and permissions.

* Namespaces

Create a namespace by initializing it:
Namespace * n = [Namespace initWithPath:(NSString *)path andName:(NSString *)name];
Both here and below, path is optional because we have top-level namespaces.  Just pass in a null.

Post it to create it:
[n post];

Save it to update it:
[n update];

Get it to find out about it:
Namespace * n = [Namespace getWithPath:(NSString *)path andName:(NSString *)name];
This may return a namespace with attributes with nothing in it, or it may contain a list of tags and/or contained namespaces.  These object values will be initialized, but, you must make additional calls to find out all there is to know about them.
To get a top-level namespace, just set the path to NULL.

Or delete it:
[n delete].


