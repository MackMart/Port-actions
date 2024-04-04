terraform {
  required_providers {
    port = {
      source  = "port-labs/port-labs"
      version = "~> 1.0.0"
    }
  }
}

provider "port" {
  client_id = "PORT_CLIENT_ID"     # or set the env var PORT_CLIENT_ID
  secret    = "PORT_CLIENT_SECRET" # or set the env var PORT_CLIENT_SECRET
}

resource "port_blueprint" "myBlueprint" {
  depends_on = [
    port_blueprint.other
  ]
  # ...blueprint properties
  identifier = "test-docs"
  icon       = "Microservice"
  title      = "Test Docs"

  properties = {
    string_props = {
      "myStringProp" = {
        title      = "My string"
        required   = false
      }
      "myUrlProp" = {
        title      = "My url"
        required   = false
        format     = "url"
      }
      "myEmailProp" = {
        title      = "My email"
        required   = false
        format     = "email"
      }
      "myUserProp" = {
        title      = "My user"
        required   = false
        format     = "user"
      }
      "myTeamProp" = {
        title      = "My team"
        required   = false
        format     = "team"
      }
      "myDatetimeProp" = {
        title      = "My datetime"
        required   = false
        format     = "date-time"
      }
      "myYAMLProp" = {
        title      = "My YAML"
        required   = false
        format     = "yaml"
      }
      "myTimerProp" = {
        title      = "My timer"
        required   = false
        format     = "timer"
      }
    }
    number_props = {
      "myNumberProp" = {
        title      = "My number"
        required   = false
      }
    }
    boolean_props = {
      "myBooleanProp" = {
        title      = "My boolean"
        required   = false
      }
    }
    object_props = {
      "myObjectProp" = {
        title      = "My object"
        required   = false
      }
    }
    array_props = {
      "myArrayProp" = {
        title      = "My array"
        required   = false
      }
    }
  }

  mirror_properties = {
    "myMirrorProp" = {
      title      = "My mirror property"
      path       = "myRelation.myStringProp"
    }
    "myMirrorPropWithMeta" = {
      title      = "My mirror property of meta property"
      path       = "myRelation.$identifier"
    }
  }

  calculation_properties = {
    "myCalculation" = {
      title       = "My calculation property"
      calculation = ".properties.myStringProp + .properties.myStringProp"
      type        = "string"
    }
    # Calculation property making use of meta-properties
    "myCalculationWithMeta" = {
      title       = "My calculation property with meta properties"
      calculation = ".identifier + \"-\" + .title + \"-\" + .properties.myStringProp"
      type        = "string"
    }
  }

  relations = {
    "myRelation" = {
      target     = port_blueprint.other.identifier
      title      = "myRelation"
      many       = false
      required   = false
    }
  }
}

resource "port_blueprint" "other" {
  # ...blueprint properties
  identifier = "test-docs-relation"
  icon       = "Microservice"
  title      = "Test Docs Relation"

  properties = {
    string_props = {
      "myStringProp" = {
        title      = "My string"
        required   = false
      }
    }
  }
}
