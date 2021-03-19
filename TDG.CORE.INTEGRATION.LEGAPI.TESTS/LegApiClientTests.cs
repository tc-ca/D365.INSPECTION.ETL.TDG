using System;
using System.Linq;
using Xunit;

namespace TDG.CORE.INTEGRATION.LEGAPI.TESTS
{
    public class LegApiClientTests
    {
        [Fact]
        public void whenRequestingSerializedAct_fromlegsandregsAPI_and_RequestFormedCorrectly_thenReceiveValidData()
        {
            var act = LegApiClient.GetActSerialized("T-19.01", "eng");

            Assert.NotNull(act);
        }

        [Fact]
        public void whenRequestingActJson_fromlegsandregsAPI_and_RequestFormedCorrectly_thenReceiveValidData()
        {
            var act = LegApiClient.GetAct("T-19.01", "eng");

            Assert.NotNull(act);
        }

        [Fact]
        public void whenRequestingRegulationJson_fromlegsandregsAPI_and_RequestFormedCorrectly_thenReceiveValidData()
        {
            var reg = LegApiClient.GetRegulation("1227358e");

            Assert.NotNull(reg);
        }
    }
}
