// FilterKey.java
// Created on Thu Apr 26 20:20:42  2001 by Apple EOModeler Version 410

import com.apple.yellow.foundation.*;
import com.apple.yellow.eocontrol.*;
import java.util.*;
import java.math.BigDecimal;

public class FilterKey extends EOClientGenericRecord {

    public FilterKey() {
        super();
    }

/*
    // If you implement the following constructor EOF will use it to
    // create your objects, otherwise it will use the default
    // constructor. For maximum performance, you should only
    // implement this constructor if you depend on the arguments.
    public FilterKey(EOEditingContext context, EOClassDescription classDesc, EOGlobalID gid) {
        super(context, classDesc, gid);
    }

    // If you add instance variables to store property values you
    // should add empty implementions of the Serialization methods
    // to avoid unnecessary overhead (the properties will be
    // serialized for you in the superclass).
    private void writeObject(java.io.ObjectOutputStream out) throws java.io.IOException {
    }

    private void readObject(java.io.ObjectInputStream in) throws java.io.IOException, java.lang.ClassNotFoundException {
    }
*/

  public NSDictionary clientDictionary() {
    if (this._clientDictionary == null) {
      NSMutableDictionary result = new NSMutableDictionary();
      result.setObjectForKey("FilterKey", "Type");
      result.setObjectForKey(this.oid(), "OID");
      result.setObjectForKey(this.filterKey(), "FilterKey");
      result.setObjectForKey(this.source().oid(), "SourceOid");
      NSMutableArray clientFilterValues = new NSMutableArray();
      for (int i = 0; i < this.filterValues().count(); i++) {
        clientFilterValues.addObject(((EOClientGenericRecord) this.filterValues().objectAtIndex(i)).clientDictionary());
      }
      if (clientFilterValues.count() > 0) {
        result.setObjectForKey(clientFilterValues, "FilterValues");
      }
      this._clientDictionary = new NSDictionary(result);
    }
    return this._clientDictionary;
  }
  public void updateClientDictionary() {
    this._clientDictionary = null;
    return;
  }
    public String filterKey() {
        return (String)storedValueForKey("filterKey");
    }

    public void setFilterKey(String value) {
        takeStoredValueForKey(value, "filterKey");
      this.updateClientDictionary();
    }

    public Number oid() {
        return (Number)storedValueForKey("oid");
    }

    public void setOid(Number value) {
        takeStoredValueForKey(value, "oid");
      this.updateClientDictionary();
    }

    public Source source() {
        return (Source)storedValueForKey("source");
    }

    public void setSource(Source value) {
        takeStoredValueForKey(value, "source");
      this.updateClientDictionary();
    }

    public NSArray filterValues() {
        return (NSArray)storedValueForKey("filterValues");
    }

    public void setFilterValues(NSMutableArray value) {
        takeStoredValueForKey(value, "filterValues");
      this.updateClientDictionary();
    }

    public void addToFilterValues(FilterValue object) {
        NSMutableArray array = (NSMutableArray)filterValues();

        willChange();
        array.addObject(object);
        this.updateClientDictionary();
    }

    public void removeFromFilterValues(FilterValue object) {
        NSMutableArray array = (NSMutableArray)filterValues();

        willChange();
        array.removeObject(object);
        this.updateClientDictionary();
    }
}
