import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models/finetune.models.tsp";
import "./serviceCustomizations.tsp";

namespace Azure.OpenAI;

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

interface FineTunes {
  #suppress "@azure-tools/cadl-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
  @summary("""
Gets a list of all fine-tune jobs owned by the Azure OpenAI resource.
The details that are returned for each fine-tune job contain besides its
identifier the base model, training and validation files, hyper parameters,
time stamps, status and events.  Events are created when the job status
changes, e.g. running or complete, and when results are uploaded.
""")
  @doc("""
Gets a list of all fine-tune jobs owned by the Azure OpenAI resource.
The details that are returned for each fine-tune job contain besides its
identifier the base model, training and validation files, hyper parameters,
time stamps, status and events. Events are created when the job status
changes, e.g. running or complete, and when results are uploaded.
""")
  @route("/fine-tunes")
  @get
  // TODO: enum value types not supported in csharp emitter, change string literal to TypeDiscriminatorKnownValues enum when fixed
  ListFineTunes is ServiceCustomizations.OpenAIListOperation<FineTune, "fine-tune">;

  #suppress "@azure-tools/cadl-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
  @summary("""
Creates a job that fine-tunes a specified model from a given training
file.
Response includes details of the enqueued job including job status and
hyper parameters.
The name of the fine-tuned model is added to the response
once complete.
""")
  @doc("""
Creates a job that fine-tunes a specified model from a given training
file.
Response includes details of the enqueued job including job status and
hyper parameters.
The name of the fine-tuned model is added to the response
once complete.
""")
  @route("/fine-tunes")
  @post
  CreateFineTune is Foundations.Operation<
    FineTuneCreation, 
    FineTune & CreatedResponse
  >;

  @summary("""
Gets details for a single fine-tune job specified by the given
fine_tune_id.
The details contain the base model, training and validation
files, hyper parameters, time stamps, status and events.
Events are created
when the job status changes, e.g. running or complete, and when results are
uploaded.
""")
  @doc("""
Gets details for a single fine-tune job specified by the given
fine_tune_id.
The details contain the base model, training and validation
files, hyper parameters, time stamps, status and events.
Events are created
when the job status changes, e.g. running or complete, and when results are
uploaded.
""")
  GetFineTune is ResourceRead<FineTune>;

  @summary("Deletes the fine-tune job specified by the given fine_tune_id.")
  @doc("Deletes the fine-tune job specified by the given fine_tune_id.")
  DeleteFineTune is ResourceDelete<FineTune>;

  #suppress "@azure-tools/cadl-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
  @summary("""
List events for the fine-tune job specified by the given fine_tune_id.
Events are created when the job status changes, e.g. running or
complete, and when results are uploaded.
""")
  @doc("""
List events for the fine-tune job specified by the given fine_tune_id.
Events are created when the job status changes, e.g. running or
complete, and when results are uploaded.
""")
  @Cadl.Rest.actionSeparator("/")
  @get
  ListFineTuneEvents is Azure.Core.ResourceAction<FineTune, 
  { 
      @doc("A flag indicating whether to stream events for the fine-tune job. If set to true,\nevents will be sent as data-only server-sent events as they become available. The stream will terminate with\na data: [DONE] message when the job is finished (succeeded, cancelled, or failed).\nIf set to false, only events generated so far will be returned..")
      @query stream: boolean
  }, ServiceCustomizations.OpenAiList<Event, TypeDiscriminator>>;

  // #suppress "@azure-tools/cadl-azure-core/use-standard-operations" "This is an existing service, we have a non-conforming operation."
  @summary("Cancels the processing of the fine-tune job specified by the given fine_tune_id.")
  @doc("Cancels the processing of the fine-tune job specified by the given fine_tune_id.")
  @post
  @action("cancel")
  @actionSeparator("/")
  CancelFineTune is ResourceAction<FineTune, {}, FineTune>;
}
