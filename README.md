fluid-obj-c
===========

Shiny new objective-c client lib for Fluidinfo

Provides an OO Obj-c interface for working with Fluidinfo's objects,
tags, values, namespaces, and permissions.

* FiClasses

Namespaces, Tags, FiObjects, Values, and Permissions are FiClasses.  All
of them have in common a boolean value, waiting.  While nothing is
done internally with this value, outside of the integration tests, you
may use it to avoid making conflicting calls to Fluidinfo using
Key-Value coding.  Every call to Fluidinfo triggers setting waiting to
true until the call has completed asynchronously.  For connectivity
issues, you're on your own - everything will always be waiting.  Feel
free to set waiting to false in order to recover.

FiClasses have no knowledge of whether they correctly represent remote
fluidinfo state.  However, if an operation on a FiClass fails and
produces an error, that error is attached to the object until another
operation is triggered.

You may get some unexpected or inconsistent results, if you execute
simultaneous operations on FiClasses.  That is a natural side-effect
of working asynchronously.

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


* Tags

Tags work pretty much just like namespaces.  The description defaults
to an empty string, and indexed defaults to false.  Note that this is
important, as you cannot change the value of indexed, later.

