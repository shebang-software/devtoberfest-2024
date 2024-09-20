/* checksum : b48477a983b8816505ab5fcc9fd16603 */
@cds.external : true
@cds.persistence.skip : true
@UI.SelectionFields : [ 'name', 'abv', 'ibu' ]
@UI.LineItem : [
  {
    $Type: 'UI.DataField',
    Value: name
  },
  {
    $Type: 'UI.DataField',
    Value: abv
  },
  {
    $Type: 'UI.DataField',
    Value: ibu
  }
]
@UI.HeaderInfo : {
  $Type: 'UI.HeaderInfoType',
  TypeName: 'Beer',
  TypeNamePlural: 'Beers',
  Title: {
    $Type: 'UI.DataField',
    Value: name
  },
  Description: {
    $Type: 'UI.DataField',
    Value: ![brewery/name]
  }
}
@UI.Facets : [
  {
    $Type: 'UI.ReferenceFacet',
    Label: 'Details',
    Target: @UI.![FieldGroup#Details]
  }
]
@UI.FieldGroup#Details : {
  $Type: 'UI.FieldGroupType',
  Data: [
    {
      $Type: 'UI.DataField',
      Value: name
    },
    {
      $Type: 'UI.DataField',
      Value: ![brewery/name]
    },
    {
      $Type: 'UI.DataField',
      Value: abv
    },
    {
      $Type: 'UI.DataField',
      Value: ibu
    }
  ]
}
entity beershop_admin.Beers {
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @Common.Label : 'Beer Name'
  name : String(100);
  @Common.Label : 'Alcohol by volume'
  abv : Decimal(3, 1);
  /** International Bitterness Unit */
  @Common.Label : 'IBU'
  ibu : Integer;
  brewery : Association to one beershop_admin.Breweries {  };
  brewery_ID : UUID;
};

@cds.external : true
@cds.persistence.skip : true
@UI.SelectionFields : [ 'name' ]
@UI.LineItem : [
  {
    $Type: 'UI.DataField',
    Value: name
  }
]
@UI.HeaderInfo : {
  $Type: 'UI.HeaderInfoType',
  TypeName: 'Brewery',
  TypeNamePlural: 'Breweries',
  Title: {
    $Type: 'UI.DataField',
    Value: name
  },
  Description: {
    $Type: 'UI.DataField',
    Value: name
  }
}
@UI.Facets : [
  {
    $Type: 'UI.ReferenceFacet',
    Label: 'Details',
    Target: @UI.![FieldGroup#Details]
  },
  {
    $Type: 'UI.ReferenceFacet',
    Label: 'Beers',
    Target: beers.![@UI].LineItem
  }
]
@UI.FieldGroup#Details : {
  $Type: 'UI.FieldGroupType',
  Data: [
    {
      $Type: 'UI.DataField',
      Value: name
    }
  ]
}
@Common.DraftRoot : {
  $Type: 'Common.DraftRootType',
  ActivationAction: 'beershop_admin.draftActivate',
  EditAction: 'beershop_admin.draftEdit',
  PreparationAction: 'beershop_admin.draftPrepare'
}
entity beershop_admin.Breweries {
  @Core.Computed : true
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @Common.Label : 'Brewery Name'
  name : String(150);
  beers : Association to many beershop_admin.Beers {  };
  @UI.Hidden : true
  key IsActiveEntity : Boolean not null default true;
  @UI.Hidden : true
  HasActiveEntity : Boolean not null default false;
  @UI.Hidden : true
  HasDraftEntity : Boolean not null default false;
  @UI.Hidden : true
  DraftAdministrativeData : Association to one beershop_admin.DraftAdministrativeData {  };
  SiblingEntity : Association to one beershop_admin.Breweries {  };
} actions {
  action draftPrepare(
    ![in] : $self,
    SideEffectsQualifier : LargeString
  ) returns beershop_admin.Breweries;
  action draftActivate(
    ![in] : $self
  ) returns beershop_admin.Breweries;
  action draftEdit(
    ![in] : $self,
    PreserveChanges : Boolean
  ) returns beershop_admin.Breweries;
};

@cds.external : true
@cds.persistence.skip : true
@UI.SelectionFields : [ 'type_String', 'type_Date' ]
@UI.LineItem : [
  {
    $Type: 'UI.DataField',
    Value: ID
  },
  {
    $Type: 'UI.DataField',
    Value: type_Boolean
  },
  {
    $Type: 'UI.DataField',
    Value: type_Int32
  },
  {
    $Type: 'UI.DataField',
    Value: type_Date
  }
]
@UI.HeaderInfo : {
  $Type: 'UI.HeaderInfoType',
  TypeName: 'TypeCheck',
  TypeNamePlural: 'TypeChecks',
  Title: {
    $Type: 'UI.DataField',
    Value: type_String
  },
  Description: {
    $Type: 'UI.DataField',
    Value: type_String
  }
}
@UI.Facets : [
  {
    $Type: 'UI.ReferenceFacet',
    Label: 'Details',
    Target: @UI.![FieldGroup#Details]
  }
]
@UI.FieldGroup#Details : {
  $Type: 'UI.FieldGroupType',
  Data: [
    {
      $Type: 'UI.DataField',
      Value: ID
    },
    {
      $Type: 'UI.DataField',
      Value: type_Boolean
    },
    {
      $Type: 'UI.DataField',
      Value: type_Int32
    },
    {
      $Type: 'UI.DataField',
      Value: type_Int64
    },
    {
      $Type: 'UI.DataField',
      Value: type_Decimal
    },
    {
      $Type: 'UI.DataField',
      Value: type_Double
    },
    {
      $Type: 'UI.DataField',
      Value: type_Date
    },
    {
      $Type: 'UI.DataField',
      Value: type_Time
    },
    {
      $Type: 'UI.DataField',
      Value: type_DateTime
    },
    {
      $Type: 'UI.DataField',
      Value: type_Timestamp
    },
    {
      $Type: 'UI.DataField',
      Value: type_String
    },
    {
      $Type: 'UI.DataField',
      Value: type_LargeString
    }
  ]
}
entity beershop_admin.TypeChecks {
  @Core.Computed : true
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @Common.Label : 'type_Boolean'
  type_Boolean : Boolean;
  @Common.Label : 'type_Int32'
  type_Int32 : Integer;
  @Common.Label : 'type_Int64'
  type_Int64 : Integer64;
  @Common.Label : 'type_Decimal'
  type_Decimal : Decimal(2, 1);
  @Common.Label : 'type_Double'
  type_Double : Double;
  @Common.Label : 'type_Date'
  type_Date : Date;
  @Common.Label : 'type_Time'
  type_Time : Time;
  @odata.Precision : 0
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : 'type_DateTime'
  type_DateTime : DateTime;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : 'type_Timestamp'
  type_Timestamp : Timestamp;
  @Common.Label : 'type_String'
  type_String : LargeString;
  @Common.Label : 'type_Binary'
  type_Binary : Binary(100);
  @Common.Label : 'type_LargeBinary'
  type_LargeBinary : LargeBinary;
  @Common.Label : 'type_LargeString'
  type_LargeString : LargeString;
  kyma_1 : Integer;
};

@cds.external : true
@cds.persistence.skip : true
@UI.SelectionFields : [ 'type_String', 'type_Date' ]
@UI.LineItem : [
  {
    $Type: 'UI.DataField',
    Value: ID
  },
  {
    $Type: 'UI.DataField',
    Value: type_Boolean
  },
  {
    $Type: 'UI.DataField',
    Value: type_Int32
  },
  {
    $Type: 'UI.DataField',
    Value: type_Date
  }
]
@UI.HeaderInfo : {
  $Type: 'UI.HeaderInfoType',
  TypeName: 'TypeCheck',
  TypeNamePlural: 'TypeChecks',
  Title: {
    $Type: 'UI.DataField',
    Value: type_String
  },
  Description: {
    $Type: 'UI.DataField',
    Value: type_String
  }
}
@UI.Facets : [
  {
    $Type: 'UI.ReferenceFacet',
    Label: 'Details',
    Target: @UI.![FieldGroup#Details]
  }
]
@UI.FieldGroup#Details : {
  $Type: 'UI.FieldGroupType',
  Data: [
    {
      $Type: 'UI.DataField',
      Value: ID
    },
    {
      $Type: 'UI.DataField',
      Value: type_Boolean
    },
    {
      $Type: 'UI.DataField',
      Value: type_Int32
    },
    {
      $Type: 'UI.DataField',
      Value: type_Int64
    },
    {
      $Type: 'UI.DataField',
      Value: type_Decimal
    },
    {
      $Type: 'UI.DataField',
      Value: type_Double
    },
    {
      $Type: 'UI.DataField',
      Value: type_Date
    },
    {
      $Type: 'UI.DataField',
      Value: type_Time
    },
    {
      $Type: 'UI.DataField',
      Value: type_DateTime
    },
    {
      $Type: 'UI.DataField',
      Value: type_Timestamp
    },
    {
      $Type: 'UI.DataField',
      Value: type_String
    },
    {
      $Type: 'UI.DataField',
      Value: type_LargeString
    }
  ]
}
@Common.DraftRoot : {
  $Type: 'Common.DraftRootType',
  ActivationAction: 'beershop_admin.draftActivate',
  EditAction: 'beershop_admin.draftEdit',
  PreparationAction: 'beershop_admin.draftPrepare'
}
entity beershop_admin.TypeChecksWithDraft {
  @Core.Computed : true
  @Core.ComputedDefaultValue : true
  key ID : UUID not null;
  @Common.Label : 'type_Boolean'
  type_Boolean : Boolean;
  @Common.Label : 'type_Int32'
  type_Int32 : Integer;
  @Common.Label : 'type_Int64'
  type_Int64 : Integer64;
  @Common.Label : 'type_Decimal'
  type_Decimal : Decimal(2, 1);
  @Common.Label : 'type_Double'
  type_Double : Double;
  @Common.Label : 'type_Date'
  type_Date : Date;
  @Common.Label : 'type_Time'
  type_Time : Time;
  @odata.Precision : 0
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : 'type_DateTime'
  type_DateTime : DateTime;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : 'type_Timestamp'
  type_Timestamp : Timestamp;
  @Common.Label : 'type_String'
  type_String : LargeString;
  @Common.Label : 'type_Binary'
  type_Binary : Binary(100);
  @Common.Label : 'type_LargeBinary'
  type_LargeBinary : LargeBinary;
  @Common.Label : 'type_LargeString'
  type_LargeString : LargeString;
  kyma_1 : Integer;
  @UI.Hidden : true
  key IsActiveEntity : Boolean not null default true;
  @UI.Hidden : true
  HasActiveEntity : Boolean not null default false;
  @UI.Hidden : true
  HasDraftEntity : Boolean not null default false;
  @UI.Hidden : true
  DraftAdministrativeData : Association to one beershop_admin.DraftAdministrativeData {  };
  SiblingEntity : Association to one beershop_admin.TypeChecksWithDraft {  };
} actions {
  action draftPrepare(
    ![in] : $self,
    SideEffectsQualifier : LargeString
  ) returns beershop_admin.TypeChecksWithDraft;
  action draftActivate(
    ![in] : $self
  ) returns beershop_admin.TypeChecksWithDraft;
  action draftEdit(
    ![in] : $self,
    PreserveChanges : Boolean
  ) returns beershop_admin.TypeChecksWithDraft;
};

@cds.external : true
@cds.persistence.skip : true
@Common.Label : 'Draft Administrative Data'
entity beershop_admin.DraftAdministrativeData {
  @UI.Hidden : true
  @Common.Label : 'Draft (Technical ID)'
  @Core.ComputedDefaultValue : true
  key DraftUUID : UUID not null;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : 'Draft Created On'
  CreationDateTime : Timestamp;
  @Common.Label : 'Draft Created By'
  CreatedByUser : String(256);
  @UI.Hidden : true
  @Common.Label : 'Draft Created By Me'
  DraftIsCreatedByMe : Boolean;
  @odata.Precision : 7
  @odata.Type : 'Edm.DateTimeOffset'
  @Common.Label : 'Draft Last Changed On'
  LastChangeDateTime : Timestamp;
  @Common.Label : 'Draft Last Changed By'
  LastChangedByUser : String(256);
  @Common.Label : 'Draft In Process By'
  InProcessByUser : String(256);
  @UI.Hidden : true
  @Common.Label : 'Draft In Process By Me'
  DraftIsProcessedByMe : Boolean;
};

@cds.external : true
service beershop_admin {};

