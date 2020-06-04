/**
 * API title
 * No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)
 *
 * OpenAPI spec version: 0.0.1
 * 
 *
 * NOTE: This class is auto generated by the swagger code generator program.
 * https://github.com/swagger-api/swagger-codegen.git
 * Do not edit the class manually.
 */


import * as $ from 'jquery';
import * as models from '../model/models';
import { Configuration } from '../configuration';

const page_info = require('../../../page_info.js.erb')

/* tslint:disable:no-unused-variable member-ordering */




export class NonprofitsApi {
    protected basePath = `${page_info.apiDomain}/api`;
    public defaultHeaders: Array<string> = [];
    public defaultExtraJQueryAjaxSettings?: JQueryAjaxSettings = null;
    public configuration: Configuration = new Configuration();

    constructor(basePath?: string, configuration?: Configuration, defaultExtraJQueryAjaxSettings?: JQueryAjaxSettings) {
        if (basePath) {
            this.basePath = basePath;
        }
        if (configuration) {
            this.configuration = configuration;
        }
        if (defaultExtraJQueryAjaxSettings) {
            this.defaultExtraJQueryAjaxSettings = defaultExtraJQueryAjaxSettings;
        }
    }

    private extendObj<T1, T2 extends T1>(objA: T2, objB: T2): T1|T2 {
        for (let key in objB) {
            if (objB.hasOwnProperty(key)) {
                objA[key] = objB[key];
            }
        }
        return objA;
    }


    /**
     * Return a nonprofit.
     * @summary Return a nonprofit.
     * @param id Status id.
     */
    public getNonprofitId(id: number, extraJQueryAjaxSettings?: JQueryAjaxSettings): JQueryPromise<models.Nonprofit > {
        let localVarPath = this.basePath + '/nonprofit/{id}'.replace('{' + 'id' + '}', encodeURIComponent(String(id)));

        let queryParameters: any = {};
        let headerParams: any = {};
        // verify required parameter 'id' is not null or undefined
        if (id === null || id === undefined) {
            throw new Error('Required parameter id was null or undefined when calling getNonprofitId.');
        }


        localVarPath = localVarPath + "?" + $.param(queryParameters);
        // to determine the Content-Type header
        let consumes: string[] = [
        ];

        // to determine the Accept header
        let produces: string[] = [
            'application/json'
        ];


        let requestOptions: JQueryAjaxSettings = {
            url: localVarPath,
            type: 'GET',
            headers: headerParams,
            processData: false
        };

        if (headerParams['Content-Type']) {
            requestOptions.contentType = headerParams['Content-Type'];
        }

        if (extraJQueryAjaxSettings) {
            requestOptions = Object.assign(requestOptions, extraJQueryAjaxSettings);
        }

        if (this.defaultExtraJQueryAjaxSettings) {
            requestOptions = Object.assign(requestOptions, this.defaultExtraJQueryAjaxSettings);
        }

        let dfd = $.Deferred();
        $.ajax(requestOptions).then(
            (data: models.Nonprofit, textStatus: string, jqXHR: JQueryXHR) =>
                dfd.resolve(jqXHR, data),
            (xhr: JQueryXHR, textStatus: string, errorThrown: string) => {
                    if(false){}
                    else if (xhr.status == 200 && 200 >= 400)
                    {
                        dfd.reject(new models.NonprofitException(xhr.responseJSON as models.Nonprofit))
                    }

                    else
                    {

                        dfd.reject(errorThrown)
                    }
            }
        );
        return dfd.promise();
    }


    /**
     * Register a nonprofit
     * @summary Register a nonprofit
     * @param Nonprofit 
     */
    public postNonprofit(Nonprofit: models.PostNonprofit, extraJQueryAjaxSettings?: JQueryAjaxSettings): JQueryPromise<models.Nonprofit > {
        let localVarPath = this.basePath + '/nonprofits';

        let queryParameters: any = {};
        let headerParams: any = {};
        // verify required parameter 'Nonprofit' is not null or undefined
        if (Nonprofit === null || Nonprofit === undefined) {
            throw new Error('Required parameter Nonprofit was null or undefined when calling postNonprofit.');
        }


        localVarPath = localVarPath + "?" + $.param(queryParameters);
        // to determine the Content-Type header
        let consumes: string[] = [
            'application/json'
        ];

        // to determine the Accept header
        let produces: string[] = [
            'application/json'
        ];


        headerParams['Content-Type'] = 'application/json';

        let requestOptions: JQueryAjaxSettings = {
            url: localVarPath,
            type: 'POST',
            headers: headerParams,
            processData: false
        };

        requestOptions.data = JSON.stringify(Nonprofit);
        if (headerParams['Content-Type']) {
            requestOptions.contentType = headerParams['Content-Type'];
        }

        if (extraJQueryAjaxSettings) {
            requestOptions = Object.assign(requestOptions, extraJQueryAjaxSettings);
        }

        if (this.defaultExtraJQueryAjaxSettings) {
            requestOptions = Object.assign(requestOptions, this.defaultExtraJQueryAjaxSettings);
        }

        let dfd = $.Deferred();
        $.ajax(requestOptions).then(
            (data: models.Nonprofit, textStatus: string, jqXHR: JQueryXHR) =>
                dfd.resolve(jqXHR, data),
            (xhr: JQueryXHR, textStatus: string, errorThrown: string) => {
                    if(false){}
                    else if (xhr.status == 201 && 201 >= 400)
                    {
                        dfd.reject(new models.NonprofitException(xhr.responseJSON as models.Nonprofit))
                    }

                    else if (xhr.status == 400 && 400 >= 400)
                    {
                        dfd.reject(new models.ValidationErrorsException(xhr.responseJSON as models.ValidationErrors))
                    }

                    else
                    {

                        dfd.reject(errorThrown)
                    }
            }
        );
        return dfd.promise();
    }

}
