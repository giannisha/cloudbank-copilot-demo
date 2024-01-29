
public static class UserContextMiddlewareExtensions
{
    public const string OidClaimType = "http://schemas.microsoft.com/identity/claims/objectidentifier";

    public static IApplicationBuilder UseUserContext(this IApplicationBuilder builder)
    {
        return builder.Use(async (context, next) =>
        {
            var oid = context.User.FindFirst(OidClaimType)?.Value;
            if (!string.IsNullOrEmpty(oid))
            {
                // Store the OID in the HttpContext.Items collection so it's accessible down the pipeline
                context.Items["UserOID"] = oid;
            }

            await next();
        });
    }
}