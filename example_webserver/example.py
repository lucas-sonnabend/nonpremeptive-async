import asyncio
from time import sleep

from starlette.applications import Starlette
from starlette.responses import PlainTextResponse
from starlette.routing import Route


async def healthcheck(request):
    return PlainTextResponse("Ok")


async def _process_request_async():
    # stall for some time to simulate processing
    sleep(7)
    return "Done!"


def _process_request_sync():
    # stall for some time to simulate processing
    sleep(7)
    return "Done!"


def _process_request_sync_busy():
    # loop for a long time to simulate CPU intensive load
    x = 0
    for i in range(10 ** 8):
        x = x + 1
    return f"Done counting to {x}"


async def processing(request):
    result = await _process_request_async()
    return PlainTextResponse(result)


async def processing_fixed(request):
    loop = asyncio.get_event_loop()
    result = await loop.run_in_executor(None, _process_request_sync)
    return PlainTextResponse(result)


async def processing_busy(request):
    loop = asyncio.get_event_loop()
    result = await loop.run_in_executor(None, _process_request_sync_busy)
    return PlainTextResponse(result)


app = Starlette(
    debug=True,
    routes=[
        Route("/health", healthcheck),
        Route("/processing", processing),
        Route("/processing_fixed", processing_fixed),
        Route("/processing_busy", processing_busy),
    ],
)
