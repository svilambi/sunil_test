// FilterValue.java
// Created on Thu Apr 26 20:20:25  2001 by Apple EOModeler Version 410

import com.apple.yellow.foundation.*;
import com.apple.yellow.eocontrol.*;
import java.util.*;
import java.math.BigDecimal;

public class FilterValue extends EOClientGenericRecord {

    public FilterValue() {
        super();
    }

/*
    // If you implement the following constructor EOF will use it to
    // create your objects, otherwise it will use the default
    // constructor. For maximum performance, you should only
    // implement this constructor if you depend on the arguments.
    public FilterValue(EOEditingContext context, EOClassDescription classDesc, EOGlobalID gid) {
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
      result.setObjectForKey("FilterValue", "Type");
      result.setObjectForKey(this.oid(), "OID");
      result.setObjectForKey(this.filterValue(), "FilterValue");
      result.setObjectForKey(this.filterKey().oid(), "FilterKeyOid");
      this._clientDictionary = new NSDictionary(result);
    }
    return this._clientDictionary;
  }
  public void updateClientDictionary() {
    this._clientDictionary = null;
    return;
  }
    public String filterValue() {
        return (String)storedValueForKey("filterValue");
    }

    public void setFilterValue(String value) {
        takeStoredValueForKey(value, "filterValue");
      this.updateClientDictionary();
    }

    public Number oid() {
        return (Number)storedValueForKey("oid");
    }

    public void setOid(Number value) {
        takeStoredValueForKey(value, "oid");
    }

    public FilterKey filterKey() {
        return (FilterKey)storedValueForKey("filterKey");
    }

    public void setFilterKey(FilterKey value) {
        takeStoredValueForKey(value, "filterKey");
      this.updateClientDictionary();
    }

    public NSArray headlineFilterValues() {
        return (NSArray)storedValueForKey("headlineFilterValues");
    }

    public void setHeadlineFilterValues(NSMutableArray value) {
        takeStoredValueForKey(value, "headlineFilterValues");
      this.updateClientDictionary();
    }

    public void addToHeadlineFilterValues(HeadlineFilterValue object) {
        NSMutableArray array = (NSMutableArray)headlineFilterValues();

        willChange();
        array.addObject(object);
        this.updateClientDictionary();
    }

    public void removeFromHeadlineFilterValues(HeadlineFilterValue object) {
        NSMutableArray array = (NSMutableArray)headlineFilterValues();

        willChange();
        array.removeObject(object);
        this.updateClientDictionary();
    }
}
